package com.interview.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;

@Service
public class SessionUtils {
    @Autowired
    HttpSession session;

    @SuppressWarnings("unchecked")
    public <T> T get(String name) {
        return (T) session.getAttribute(name);
    }

    @SuppressWarnings("unchecked")
    public <T> T set(String name, Object value) {
        session.setAttribute(name, value);
        return (T) session.getAttribute(name);
    }

    public void remove(String name) {
        session.removeAttribute(name);
    }

}
