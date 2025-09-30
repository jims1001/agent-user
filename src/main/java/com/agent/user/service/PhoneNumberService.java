package com.agent.user.service;

import com.agent.user.utils.PhoneUtil;
import com.google.i18n.phonenumbers.NumberParseException;
import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;
import org.springframework.stereotype.Service;

@Service
public class PhoneNumberService {

    private final PhoneUtil phoneUtil;

    public PhoneNumberService(PhoneUtil phoneUtil1) {
        this.phoneUtil = phoneUtil1;
    }

    public boolean isValidPhoneNumber(String phoneNumber, String defaultRegion) {
        try {
            Phonenumber.PhoneNumber parsedNumber = phoneUtil.phoneNumberUtil().parse(phoneNumber, defaultRegion);
            return phoneUtil.phoneNumberUtil().isValidNumber(parsedNumber);
        } catch (NumberParseException e) {
            System.err.println("Error parsing phone number: " + e.getMessage());
            return false;
        }
    }

    public String formatPhoneNumber(String phoneNumber, String defaultRegion, PhoneNumberUtil.PhoneNumberFormat format) {
        try {
            Phonenumber.PhoneNumber parsedNumber = phoneUtil.phoneNumberUtil().parse(phoneNumber, defaultRegion);
            return phoneUtil.phoneNumberUtil().format(parsedNumber, format);
        } catch (NumberParseException e) {
            System.err.println("Error parsing phone number: " + e.getMessage());
            return null;
        }
    }

    public Phonenumber.PhoneNumber getPhoneNumberDetails(String phoneNumber, String defaultRegion) {
        try {
            return phoneUtil.phoneNumberUtil().parse(phoneNumber, defaultRegion);
        } catch (NumberParseException e) {
            System.err.println("Error parsing phone number: " + e.getMessage());
            return null;
        }
    }

    public PhoneNumberUtil.PhoneNumberType getNumberType(String phoneNumber, String defaultRegion) {
        try {
            Phonenumber.PhoneNumber parsedNumber = phoneUtil.phoneNumberUtil().parse(phoneNumber, defaultRegion);
            return phoneUtil.phoneNumberUtil().getNumberType(parsedNumber);
        } catch (NumberParseException e) {
            System.err.println("Error parsing phone number: " + e.getMessage());
            return null;
        }
    }
}