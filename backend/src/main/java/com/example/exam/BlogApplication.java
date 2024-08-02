package com.example.exam;

import com.example.exam.post.Post;
import com.example.exam.post.PostRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import static org.springframework.data.web.config.EnableSpringDataWebSupport.PageSerializationMode.VIA_DTO;

@SpringBootApplication
@EnableScheduling
@EnableSpringDataWebSupport(pageSerializationMode = VIA_DTO)
public class BlogApplication {
    public static void main(String[] args) {
        SpringApplication.run(BlogApplication.class, args);
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:19999")
                        .allowedMethods("GET", "POST", "PUT", "DELETE")
                        .allowedHeaders("*");
            }
        };
    }

    @Bean
    public CommandLineRunner initData(PostRepository postRepository) {
        return args -> {
            if (postRepository.count() == 0) {  // 데이터베이스가 비어있을 때만 실행
                for (int i = 1; i <= 100; i++) {
                    Post post = new Post();
                    post.setTitle("Test Title " + i);
                    post.setContent("Test Content " + i);
                    postRepository.save(post);
                }
                System.out.println("100개의 테스트 게시물이 생성되었습니다.");
            }
        };
    }
}