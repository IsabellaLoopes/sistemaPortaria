package com.portariaQrCode.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Criptografia {
	public static String encripta(String senha) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(senha.getBytes());
            return Base64.encode(digest.digest());
        } catch (NoSuchAlgorithmException ns) {
            ns.printStackTrace();
            return senha;
        }
    }

    public static final void main (String[] argv) {
        System.out.println(Criptografia.encripta("@floranda"));
    }
}
