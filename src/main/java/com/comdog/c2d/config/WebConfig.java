package com.comdog.c2d.config;
// import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
// import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration 
public class WebConfig implements WebMvcConfigurer {

//     @Value("${kopo.upload.url}")
//     private String uploadUrl;

//     @Override
//     public void addResourceHandlers(ResourceHandlerRegistry registry) {
//         registry.addResourceHandler("/upload/**")
//                 .addResourceLocations(uploadUrl);
//     }
}