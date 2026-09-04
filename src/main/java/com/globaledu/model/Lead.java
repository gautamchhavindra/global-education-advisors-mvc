package com.globaledu.model;

public class Lead {
    private int id;
    private String fullName;
    private String emailAddress;
    private String highestQualification;
    private String preferredCountry;
    private String phoneNumber;
    private String createDate; // New Field

    public Lead() {
    }

    public Lead(int id, String fullName, String emailAddress, String highestQualification, String preferredCountry,
            String phoneNumber, String createDate) {
        this.id = id;
        this.fullName = fullName;
        this.emailAddress = emailAddress;
        this.highestQualification = highestQualification;
        this.preferredCountry = preferredCountry;
        this.phoneNumber = phoneNumber;
        this.createDate = createDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getHighestQualification() {
        return highestQualification;
    }

    public void setHighestQualification(String highestQualification) {
        this.highestQualification = highestQualification;
    }

    public String getPreferredCountry() {
        return preferredCountry;
    }

    public void setPreferredCountry(String preferredCountry) {
        this.preferredCountry = preferredCountry;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}
