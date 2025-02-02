package com.notetaker.helper;

public class GeneralUtility {

	public static String concat(String... strings) {
		return concat(null, strings);
	}
	
	public static String concat(Exception e, String... strings) {
		if (strings == null) {
			return "";
		}
		StringBuffer sb = new StringBuffer();
		for (String str : strings) {
			if (str != null) {
				sb.append(str);
			}
		}
		
		if(e != null) {
			sb.append(e);
		}
		return sb.toString();
	}
}
