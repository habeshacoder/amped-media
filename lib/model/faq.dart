class FAQItem {
  // final String category;
  final String question;
  final String answer;
  final String category;

  FAQItem({
    required this.category,
    required this.question,
    required this.answer,
  });
}

class CustomerJourney {
  // final String category;
  final String category;
  final String step;
  final List<String> description;

  CustomerJourney({
    required this.category,
    required this.step,
    required this.description,
  });
}

//
final List<CustomerJourney> customerJourneys = [
  CustomerJourney(
      category: "all",
      step: "1st Step – Registering and Logging In",
      description: [
        '• Navigate to the Profile after install and get in to AMPED media app ',
        '• click on the "Signin" from lists',
        '• click on the "Create new account"button from login page',
        '• Fill out the registration form with required details such as username, email, and password.',
        '• Click on the "IGN UP" button to create an account.',
        '• Once registered, log in using the provided credentials on the login page.'
      ]),
  CustomerJourney(
      category: "all",
      step: "2nd Step – Searching for Materials",
      description: [
        '• Navigate to the home page after logging in.',
        '• Use the search bar to search for materials based on keywords or categories.',
        '• Browse through the search results to find desired materials.'
      ]),
  CustomerJourney(
      category: "all",
      step: "3rd Step – Uploading Materials",
      description: [
        '• Log in to the dashboard using publisher credentials.',
        '• Click on the "Upload Material" button.',
        '• Fill out the upload form with details such as material name, description, and file upload.',
        '• Click on the "Upload" button to submit the material.'
      ]),
  CustomerJourney(
      category: "all",
      step: "4th Step – Creating a Channel",
      description: [
        '• Navigate to the profile after logging in.',
        '• Click on the "Create Channel" option.',
        '• Fill out the channel creation form with details such as channel name and description.',
        '• Click on the "Create" button to create the channel.'
      ]),
];
//

final List<FAQItem> faqItems = [
  FAQItem(
      category: "CJ",
      question:
          "Does AMPEND Media offer marketing and promotion services for publishers?",
      answer:
          "Absolutely! AMPEND Media provides marketing and promotion services to help publishers reach a wider audience and increase exposure for their publications. Our marketing team will work with you to create targeted campaigns and promotional strategies."),
  FAQItem(
      category: "CJ",
      question: "Can I contribute user-generated content to AMPEND Media?",
      answer:
          "Yes, AMPEND Media welcomes user-generated content submissions across various media formats. Whether it's articles, stories, or podcasts, we encourage users to share their creative work with our community. Our editorial team will review submissions for quality and suitability."),
  FAQItem(
      category: "CJ",
      question: '- What file formats are supported for uploading materials?',
      answer:
          'We support various file formats, including MP3 for audio, EPUB for e-books. Ensure your material meets the specified format requirements before uploading.'),
  FAQItem(
      category: "CJ",
      question: '- Can I promote my materials on the platform?',
      answer:
          'Yes, publishers can promote their materials through featured listings, sponsored placements, and targeted advertising campaigns to increase visibility and reach a wider audience.'),
  FAQItem(
      category: "CJ",
      question: '- Do I retain ownership of my materials after uploading them?',
      answer: 'Publishers maintain ownership rights of their materials.'),
];

//
List<FAQItem> getFAQsByCategory(String category) {
  return faqItems.where((item) => item.category == category).toList();
}

List<CustomerJourney> getCutomerJourneyByCategory(String category) {
  return customerJourneys.where((item) => item.category == category).toList();
}
