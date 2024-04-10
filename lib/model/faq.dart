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

final List<CustomerJourney> customerJourneys = [
  CustomerJourney(
      category: "CJ",
      step: "1st Step – Registration On The App Of Kidmeasbeza",
      description: [
        '•Customer should provide all needed personal information and pick up location information of the product (oil)',
        '•While Registering the customer is expected to pay 30 birr for subscription fee ',
      ]),
  CustomerJourney(
      category: "CJ",
      step: "2nd Step - Payment And Order",
      description: [
        "10 liter oil- 1300 birr",
        "15 liter oil - 1950  birr ",
        "20 litter oil- 2600 birr",
        "For instance , 30(sub)+1300= 1330 birr per person "
      ]),
  CustomerJourney(category: "CJ", step: "3rd -Product Pick Up ", description: [
    'Clients will go to the district of the their chose to collect the oil ',
  ]),
  CustomerJourney(
      category: "CJ",
      step: "4th – Receive Notification SMS Email ",
      description: ["They will be receive a conformation text or SMS"]),
];

final List<FAQItem> faqItems = [
  FAQItem(
    category: "all",
    question: '-What is the aim of the kidmeasbeza?',
    answer:
        'The rationale behind creating the KidmeAsbeza Project is the current high level of price inflation of commodities especially food items that bring about high cost of living to lower- and middle-income households. Kidmeasbeza will provide grocery with a constant price through out the year.',
  ),
  FAQItem(
      category: "all",
      question: "-How many times can you register per year ?",
      answer: "Ones a year"),
  FAQItem(
      category: "all",
      question: "-Where can I receive the product (oil )?",
      answer: "On the district you have registered "),
  FAQItem(
      category: "all",
      question: "-Whom to contact for more information? ",
      answer: "Call center – xxxx"),
  FAQItem(
      category: "all",
      question: "-How long is the project going to last? ",
      answer: "This is a continuous project which will be revised every year "),
  FAQItem(
      category: "all",
      question: "-Can we use  more than one phone number? ",
      answer: "No, only one number can be used per person "),
  FAQItem(
      category: "all",
      question:
          "-In case of changing phone number , how can we include the new number on the program ?",
      answer:
          "   please contact the call center so they can replace your number or update it on our setting “ account management “button ."),
  FAQItem(
      category: "all",
      question: "-What is the proof for the sustainability?",
      answer:
          "Incase of delay we will provide penalty for the customer. We have a long term agreement with our vendor ,that shows the sustainability on delivery and price ."),
  FAQItem(
      category: "all",
      question: "-What is the ingredient of the oil ?",
      answer: "The ingredient is sunflower "),
  FAQItem(
      category: "all",
      question: "-Where is the head office located ?",
      answer:
          "Kera , in front of salvatory wood work , Next to lidiya building . Alexander pushkin road "),
  FAQItem(
      category: "all",
      question: "-How long will it take for delivery ?",
      answer:
          " first round will take 60 days , other than that the oil will be delivered every month ."),
  FAQItem(
      category: "all",
      question: "-Can we change the quantity and pickup location?",
      answer:
          "-when making the order for the next month you are able to make the change ."),
  FAQItem(
      category: "all",
      question: "-Is it only oil that Kidemeasebza provide for the community ?",
      answer:
          "As the name indicates the project is aimed to include all asbeza’s ( grocery ) needed in our daily life. Our launch project focuses on the oil for now.   "),
  FAQItem(
      category: "all",
      question: "-Does Kidemeasebza provide delivery?",
      answer:
          "No,we only deliver to the districts ( wereda) of your selection ."),
  FAQItem(
      category: "all",
      question:
          "-How can I collect the product if I couldn’t collect it with in the given 10 days ?",
      answer: "Please contact the call center ."),
  FAQItem(
      category: "all",
      question:
          "-After making payment and choosing quantity is it possible to cancel the order ?",
      answer: "no it is not possible "),
];
List<FAQItem> getFAQsByCategory(String category) {
  return faqItems.where((item) => item.category == category).toList();
}

List<CustomerJourney> getCutomerJourneyByCategory(String category) {
  return customerJourneys.where((item) => item.category == category).toList();
}
