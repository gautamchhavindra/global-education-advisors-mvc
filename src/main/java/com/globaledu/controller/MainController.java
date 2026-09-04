package com.globaledu.controller;

import com.globaledu.model.Lead;
import com.globaledu.model.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @PostConstruct
    public void initDatabase() {
        // Updated table schema to include create_date column
        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS leads (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "full_name TEXT, " +
                "email_address TEXT, " +
                "highest_qualification TEXT, " +
                "preferred_country TEXT, " +
                "phone_number TEXT, " +
                "create_date TEXT DEFAULT CURRENT_TIMESTAMP)"); // Tracking timestamp

        jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS users (" +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "user_name TEXT, " +
                "email_address TEXT UNIQUE, " +
                "password TEXT)");

        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM users WHERE email_address = ?",
                Integer.class, "chhavindra.gautam@gmail.com");
        if (count == null || count == 0) {
            String hashedPassword = BCrypt.hashpw("J1a2m3u4@5", BCrypt.gensalt());
            jdbcTemplate.update("INSERT INTO users (user_name, email_address, password) VALUES (?, ?, ?)",
                    "chhavindra", "chhavindra.gautam@gmail.com", hashedPassword);
        }

        try {
            jdbcTemplate.execute("ALTER TABLE leads ADD COLUMN create_date TEXT DEFAULT CURRENT_TIMESTAMP");
            System.out.println(">> Database Migration: successfully added column 'create_date' to table 'leads'");
        } catch (Exception e) {
            // Keeps the application from crashing if the column already exists
            System.out.println(">> Database Check: 'create_date' column already present.");
        }
    }

    @GetMapping("/")
    public String showLandingPage() {
        return "landing";
    }

    @PostMapping("/submit-lead")
    public String submitLead(@RequestParam(name = "fullName") String fullName,
            @RequestParam(name = "emailAddress") String emailAddress,
            @RequestParam(name = "highestQualification") String highestQualification,
            @RequestParam(name = "preferredCountry") String preferredCountry,
            @RequestParam(name = "phoneNumber") String phoneNumber,
            Model model) {

        // Enforcing local Indian Standard Time manually for SQLite timestamp
        // consistency
        jdbcTemplate.update(
                "INSERT INTO leads (full_name, email_address, highest_qualification, preferred_country, phone_number, create_date) "
                        +
                        "VALUES (?, ?, ?, ?, ?, datetime('now', 'localtime'))",
                fullName, emailAddress, highestQualification, preferredCountry, phoneNumber);
        model.addAttribute("successMessage", "Your counselling details have been submitted successfully!");
        return "landing";
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam(name = "emailAddress") String emailAddress,
            @RequestParam(name = "password") String password,
            HttpSession session, Model model) {

        String sql = "SELECT id, user_name, email_address, password FROM users WHERE email_address = ?";

        // Using .query() avoids EmptyResultDataAccessException completely
        List<User> users = jdbcTemplate.query(sql, (rs, rNum) -> new User(
                rs.getInt("id"),
                rs.getString("user_name"),
                rs.getString("email_address"),
                rs.getString("password")), emailAddress);

        // If the list is not empty, a user with that email was found
        if (!users.isEmpty()) {
            User user = users.get(0);
            // Verify the encrypted password
            if (BCrypt.checkpw(password, user.getPassword())) {
                session.setAttribute("loggedInUser", user);
                return "redirect:/dashboard";
            }
        }

        // Fallback if email doesn't exist OR password fails
        model.addAttribute("errorMessage", "Invalid Email or Password Credentials.");
        return "login";
    }

    // Modified Dashboard with Live DB Search Filter mapping
    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam(name = "search", required = false) String search,
            HttpSession session, Model model) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null)
            return "redirect:/login";

        List<Lead> leads;
        String sql;

        if (search != null && !search.trim().isEmpty()) {

            sql = "SELECT id, full_name, email_address, highest_qualification, preferred_country, phone_number, create_date "
                    +
                    "FROM leads WHERE full_name LIKE ? OR email_address LIKE ? OR preferred_country LIKE ? ORDER BY id DESC";
            String queryParam = "%" + search.trim() + "%";
            leads = jdbcTemplate.query(sql,
                    (rs, rNum) -> new Lead(rs.getInt("id"), rs.getString("full_name"), rs.getString("email_address"),
                            rs.getString("highest_qualification"), rs.getString("preferred_country"),
                            rs.getString("phone_number"), rs.getString("create_date")),
                    queryParam, queryParam, queryParam);
            model.addAttribute("currentSearch", search);
        } else {

            sql = "SELECT id, full_name, email_address, highest_qualification, preferred_country, phone_number, create_date "
                    +
                    "FROM leads ORDER BY id DESC";
            leads = jdbcTemplate.query(sql,
                    (rs, rNum) -> new Lead(rs.getInt("id"), rs.getString("full_name"), rs.getString("email_address"),
                            rs.getString("highest_qualification"), rs.getString("preferred_country"),
                            rs.getString("phone_number"), rs.getString("create_date")));
        }

        model.addAttribute("leads", leads);
        model.addAttribute("user", loggedInUser);
        return "dashboard";
    }

    @GetMapping("/create-user")
    public String showCreateUserPage(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null)
            return "redirect:/login";
        model.addAttribute("user", loggedInUser);
        return "create-user";
    }

    @PostMapping("/create-user")
    public String processCreateUser(@RequestParam(name = "userName") String userName,
            @RequestParam(name = "emailAddress") String emailAddress,
            @RequestParam(name = "password") String password,
            HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null)
            return "redirect:/login";

        try {
            String encrypted = BCrypt.hashpw(password, BCrypt.gensalt());
            jdbcTemplate.update("INSERT INTO users (user_name, email_address, password) VALUES (?, ?, ?)",
                    userName, emailAddress, encrypted);
            model.addAttribute("successMessage", "Advisor account created successfully!");
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Registration failed. Email might already exist.");
        }
        model.addAttribute("user", loggedInUser);
        return "create-user";
    }

    @GetMapping("/users-list")
    public String showUsersList(HttpSession session, Model model) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null)
            return "redirect:/login";

        // Fetch all active system advisors
        List<User> users = jdbcTemplate.query(
                "SELECT id, user_name, email_address FROM users ORDER BY id DESC",
                (rs, rNum) -> new User(rs.getInt("id"), rs.getString("user_name"), rs.getString("email_address"), ""));

        model.addAttribute("users", users);
        model.addAttribute("user", loggedInUser); // Keeps track of who is logged in
        return "users-list";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
