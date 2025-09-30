package com.agent.user.utils;

import com.google.i18n.phonenumbers.PhoneNumberUtil;

public class PhoneUtil {

    public PhoneNumberUtil phoneNumberUtil() {
        // PhoneNumberUtil.getInstance() 方法是线程安全的，并且会返回一个单例实例
        return PhoneNumberUtil.getInstance();
    }
}
