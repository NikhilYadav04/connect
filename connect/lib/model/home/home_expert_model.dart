import 'package:connect/model/experts/expert_detail_card_model.dart';

class Developer {
  final String name;
  final String subtitle;
  final double rate;
  final double rating;
  final int reviewCount;
  final String profileImageUrl;
  final String languages;
  final String experience;
  final String qualification;
  final List<String> expertise;
  final String about;
  final double overallRating;
  final List<RatingExpertDetailsModel> reviews;

  Developer({
    required this.name,
    required this.subtitle,
    required this.rate,
    required this.rating,
    required this.reviewCount,
    required this.profileImageUrl,
    required this.languages,
    required this.experience,
    required this.qualification,
    required this.expertise,
    required this.about,
    required this.overallRating,
    required this.reviews,
  });
}

final List<Developer> developers = [
  Developer(
    name: "Sophia Lee",
    subtitle: "UI/UX Designer at Apple",
    rate: 3.0,
    rating: 4.7,
    reviewCount: 89,
    profileImageUrl: "https://randomuser.me/api/portraits/women/65.jpg",
    languages: "English, Korean",
    experience: "Exp - 4 Years",
    qualification: "BFA in Graphic Design",
    expertise: ["UI Design", "UX Research", "Prototyping"],
    about:
        "Passionate UI/UX designer with a knack for creating delightful user experiences. Sophia specializes in transforming complex problems into elegant, user-friendly interfaces. Her work bridges the gap between design and functionality, and she thrives in collaborative, fast-paced environments where innovation and creativity drive success.",
    overallRating: 4.7,
    reviews: reviews,
  ),
  Developer(
    name: "David Kim",
    subtitle: "Backend Engineer at Amazon",
    rate: 78.0,
    rating: 4.9,
    reviewCount: 120,
    profileImageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
    languages: "English, Korean",
    experience: "Exp - 6 Years",
    qualification: "MS in Computer Science",
    expertise: ["Node.js", "AWS", "Microservices", "Kafka", "Docker"],
    about:
        "Experienced backend engineer focused on building scalable and secure systems. David has a deep understanding of cloud architecture, microservices, and database optimization, allowing him to design systems that perform reliably under heavy load. He is passionate about mentoring junior engineers and constantly seeks opportunities to adopt cutting-edge technologies.",
    overallRating: 4.9,
    reviews: reviews,
  ),
  Developer(
    name: "Emily Chen",
    subtitle: "Mobile Developer at Spotify",
    rate: 4.5,
    rating: 4.8,
    reviewCount: 75,
    profileImageUrl: "https://randomuser.me/api/portraits/women/48.jpg",
    languages: "English, Mandarin",
    experience: "Exp - 5 Years",
    qualification: "BS in Software Engineering",
    expertise: ["Flutter", "Kotlin", "Swift"],
    about:
        "Mobile developer delivering smooth and responsive user experiences. Emily excels at building cross-platform apps with intuitive UIs and high performance. She believes in writing clean, maintainable code and enjoys experimenting with animations and new frameworks to enhance the user experience.",
    overallRating: 4.8,
    reviews: reviews,
  ),
  Developer(
    name: "Michael Scott",
    subtitle: "Frontend Developer at Netflix",
    rate: 6.15,
    rating: 4.5,
    reviewCount: 55,
    profileImageUrl: "https://randomuser.me/api/portraits/men/15.jpg",
    languages: "English",
    experience: "Exp - 10 Years",
    qualification: "BA in Computer Science",
    expertise: ["React", "Redux", "TypeScript", "Rust", "Mongoose"],
    about:
        "Frontend expert with a focus on building engaging UIs that keep users coming back. Michael’s extensive experience includes designing responsive layouts, optimizing performance, and implementing modern design systems. He has a keen eye for detail and believes that great design starts with empathy for the user.",
    overallRating: 4.5,
    reviews: reviews,
  ),
  Developer(
    name: "Aisha Khan",
    subtitle: "Cloud Architect at Microsoft",
    rate: 7.5,
    rating: 4.9,
    reviewCount: 102,
    profileImageUrl: "https://randomuser.me/api/portraits/women/21.jpg",
    languages: "English, Urdu",
    experience: "Exp - 8 Years",
    qualification: "MS in Cloud Computing",
    expertise: ["Azure", "DevOps", "Kubernetes"],
    about:
        "Specialist in cloud solutions and infrastructure automation, Aisha designs scalable and secure cloud environments that support modern applications. She has extensive experience migrating on-prem systems to the cloud and is passionate about building resilient architectures that ensure high availability and cost efficiency.",
    overallRating: 4.9,
    reviews: reviews,
  ),
  Developer(
    name: "Liam Rodriguez",
    subtitle: "Data Scientist at Facebook",
    rate: 5.5,
    rating: 4.6,
    reviewCount: 88,
    profileImageUrl: "https://randomuser.me/api/portraits/men/54.jpg",
    languages: "English, Spanish",
    experience: "Exp - 7 Years",
    qualification: "PhD in Data Science",
    expertise: ["Machine Learning", "Data Analysis", "Python"],
    about:
        "Data scientist with a passion for uncovering insights from complex data. Liam builds predictive models and data pipelines to transform raw information into actionable strategies. His work has contributed to product improvements and customer satisfaction by enabling data-driven decision-making at scale.",
    overallRating: 4.6,
    reviews: reviews,
  ),
  Developer(
    name: "Isabella Martinez",
    subtitle: "AI Engineer at OpenAI",
    rate: 8.0,
    rating: 4.95,
    reviewCount: 150,
    profileImageUrl: "https://randomuser.me/api/portraits/women/85.jpg",
    languages: "English, Spanish",
    experience: "Exp - 6 Years",
    qualification: "MS in Artificial Intelligence",
    expertise: ["TensorFlow", "PyTorch", "Deep Learning"],
    about:
        "AI engineer with a passion for building intelligent systems that learn and adapt. Isabella develops advanced models for natural language processing and computer vision, contributing to state-of-the-art research and production-ready solutions.",
    overallRating: 4.95,
    reviews: reviews,
  ),
  Developer(
    name: "Noah Patel",
    subtitle: "Full Stack Developer at Shopify",
    rate: 4.2,
    rating: 4.7,
    reviewCount: 67,
    profileImageUrl: "https://randomuser.me/api/portraits/men/72.jpg",
    languages: "English, Hindi",
    experience: "Exp - 5 Years",
    qualification: "BE in Computer Engineering",
    expertise: ["Node.js", "React", "GraphQL"],
    about:
        "Full stack developer skilled in creating robust web applications from concept to deployment. Noah enjoys working with modern frameworks and believes in writing efficient, reusable code that scales with product demands.",
    overallRating: 4.7,
    reviews: reviews,
  ),
  Developer(
    name: "Amelia Nguyen",
    subtitle: "DevOps Engineer at Slack",
    rate: 5.8,
    rating: 4.85,
    reviewCount: 95,
    profileImageUrl: "https://randomuser.me/api/portraits/women/66.jpg",
    languages: "English, Vietnamese",
    experience: "Exp - 6 Years",
    qualification: "BS in Information Systems",
    expertise: ["Docker", "Kubernetes", "CI/CD"],
    about:
        "DevOps engineer passionate about automating deployments and improving system reliability. Amelia creates pipelines that support rapid development and stable production environments, focusing on security and scalability.",
    overallRating: 4.85,
    reviews: reviews,
  ),
  Developer(
    name: "Ethan Brown",
    subtitle: "Cybersecurity Specialist at Cisco",
    rate: 6.9,
    rating: 4.8,
    reviewCount: 112,
    profileImageUrl: "https://randomuser.me/api/portraits/men/45.jpg",
    languages: "English",
    experience: "Exp - 9 Years",
    qualification: "MS in Cybersecurity",
    expertise: ["Network Security", "Penetration Testing", "Encryption"],
    about:
        "Cybersecurity specialist dedicated to protecting digital assets and ensuring compliance. Ethan performs vulnerability assessments and designs security architectures that safeguard organizations from emerging threats.",
    overallRating: 4.8,
    reviews: reviews,
  ),
  Developer(
    name: "Olivia Park",
    subtitle: "Product Manager at Airbnb",
    rate: 7.3,
    rating: 4.9,
    reviewCount: 130,
    profileImageUrl: "https://randomuser.me/api/portraits/women/58.jpg",
    languages: "English, Korean",
    experience: "Exp - 7 Years",
    qualification: "MBA in Product Management",
    expertise: ["Agile", "Roadmap Planning", "User Research"],
    about:
        "Product manager skilled in leading cross-functional teams to deliver customer-centric solutions. Olivia excels at turning user feedback into actionable product strategies and aligning stakeholders towards a shared vision.",
    overallRating: 4.9,
    reviews: reviews,
  ),
];
