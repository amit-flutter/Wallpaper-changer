import 'dart:math';
import 'package:gita_wallpaper/models/gita_quote.dart';

class GitaService {
  static final List<GitaQuote> quotes = [
    GitaQuote(
      quote: "You have a right to perform your prescribed duty, but you are not entitled to the fruits of action.",
      chapter: "2",
      verse: "47",
    ),
    GitaQuote(
      quote: "The mind is restless, turbulent, obstinate and very strong, O Krishna, and to subdue it is more difficult than controlling the wind.",
      chapter: "6",
      verse: "34",
    ),
    GitaQuote(
      quote: "Man is made by his belief. As he believes, so he is.",
      chapter: "10",
      verse: "3",
    ),
    GitaQuote(
      quote: "The greatest religion is to be true to this dharma; neglecting it has caused the ruin of many.",
      chapter: "12",
      verse: "20",
    ),
    GitaQuote(
      quote: "I am the source of all spiritual and material worlds. Everything emanates from Me. The wise who perfectly engage in My devotional service get attached to Me and attain complete perfection.",
      chapter: "10",
      verse: "8",
    ),
    GitaQuote(
      quote: "When a man dwells on the objects of sense, he creates an attraction for them; attraction develops into desire, and desire breeds anger.",
      chapter: "2",
      verse: "62",
    ),
    GitaQuote(
      quote: "The soul can never be cut to pieces by any weapon, nor burned by fire, nor moistened by water, nor withered by the wind.",
      chapter: "2",
      verse: "23",
    ),
    GitaQuote(
      quote: "As a lamp is sheltered from the wind in a windless place, so is the mind steadied by practicing yoga.",
      chapter: "6",
      verse: "19",
    ),
    GitaQuote(
      quote: "Yoga is skill in action. Yoga is the path to enlightenment. It is the mastery of body, mind, and senses.",
      chapter: "2",
      verse: "50",
    ),
    GitaQuote(
      quote: "The wise see knowledge and action as a single unit. The wise see both as a single path which leads to the supreme.",
      chapter: "4",
      verse: "25",
    ),
    GitaQuote(
      quote: "Among the dispositions, I am the wisdom of the wise, and I am the splendor of the splendid.",
      chapter: "10",
      verse: "26",
    ),
    GitaQuote(
      quote: "Better to live your own dharma imperfectly than to live an imitation of somebody else's life with perfection.",
      chapter: "3",
      verse: "35",
    ),
    GitaQuote(
      quote: "One who is not disturbed in mind even amidst the threefold miseries or elated when there is happiness, and who has steady conviction in the principles of devotion, is certainly situated in transcendental goodness.",
      chapter: "2",
      verse: "56",
    ),
    GitaQuote(
      quote: "Arjuna, please hear now how, by practicing yoga, you can work while seeking perfection; by understanding this knowledge completely, you can free yourself from the bonds of karma.",
      chapter: "3",
      verse: "13",
    ),
    GitaQuote(
      quote: "The mind acts like a person afflicted with jaundice, for whom everything looks yellow, poisoning beauty with a single drop of cloud.",
      chapter: "12",
      verse: "17",
    ),
    GitaQuote(
      quote: "A person is said to have achieved yoga, the union with the Self, when the perfectly disciplined mind gets absorbed in the Self, and gets fully satisfied in the consciousness of the Self only.",
      chapter: "6",
      verse: "20",
    ),
    GitaQuote(
      quote: "Even if you are considered the greatest sinner, you can cross over all the sins with the boat of transcendental knowledge.",
      chapter: "4",
      verse: "36",
    ),
    GitaQuote(
      quote: "For those whose minds are attached to My personal features, always engaged in worshiping Me with all their hearts, the path of bhakti-yoga is all bliss and is very dear.",
      chapter: "12",
      verse: "2",
    ),
    GitaQuote(
      quote: "Yoga is the journey of the self, through the self, to the self.",
      chapter: "6",
      verse: "1",
    ),
    GitaQuote(
      quote: "When meditation is mastered, the mind is unwavering like the flame of a candle in a windless place.",
      chapter: "6",
      verse: "19",
    ),
  ];

  static GitaQuote getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  static List<GitaQuote> getAllQuotes() {
    return quotes;
  }
}
