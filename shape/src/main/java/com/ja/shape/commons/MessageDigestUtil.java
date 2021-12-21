package com.ja.shape.commons;

import java.security.*;

public class MessageDigestUtil {
	
	public static String getPasswordHashCode(String password) {
		
		password = password + "@ja";
		
		String hashCode = null;
		
		StringBuilder sb = new StringBuilder();
		try {
			
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");
			
			messageDigest.reset();
			messageDigest.update(password.getBytes("UTF-8"));
			
			byte[] chars = messageDigest.digest();
			
			for (int i = 0; i < chars.length; i++) {
				String tmp = Integer.toHexString(0xff & chars[i]);
				if (tmp.length() == 1)
					sb.append("0");
				sb.append(tmp);
			}
			
			hashCode = sb.toString();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hashCode;
		
	}
	
	
}

