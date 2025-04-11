package com.jd.common;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.jd.entity.Teacher;
import com.jd.entity.User;

import java.util.Date;

public class TokenUtil {

    private static final long EXPIRE_TIME= 10*60*60*1000;
    private static final String TOKEN_SECRET="txdy";  //密钥盐

    /**
     * 签名生成
     * @param teacher
     * @return
     */
    public static String sign(Teacher teacher){
        String token = null;
        try {
            Date expiresAt = new Date(System.currentTimeMillis() + EXPIRE_TIME);
            token = JWT.create()
                    .withIssuer("auth0")
                    .withClaim("teacherName", teacher.getTName())
                    .withExpiresAt(expiresAt)
                    // 使用了HMAC256加密算法。
                    .sign(Algorithm.HMAC256(TOKEN_SECRET));
        } catch (Exception e){
            e.printStackTrace();
        }
        return token;
    }

    /**
     * 签名验证
     * @param token
     * @return
     */
    public static boolean verify(String token){
        try {
            JWTVerifier verifier = JWT.require(Algorithm.HMAC256(TOKEN_SECRET)).withIssuer("auth0").build();
            DecodedJWT jwt = verifier.verify(token);
            System.out.println("认证通过：");
            System.out.println("username: " + jwt.getClaim("username").asString());
            System.out.println("过期时间：      " + jwt.getExpiresAt());
            return true;
        } catch (Exception e){
            return false;
        }
    }

//    public static Claims parseJWT(String jwt) throws Exception {
//        SecretKey secretKey = generalKey();
//        return Jwts.parser()
//                .setSigningKey(secretKey)
//                .parseClaimsJws(jwt)
//                .getBody();
//    }
}
