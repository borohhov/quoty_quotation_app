/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
import axios from 'axios';
import {onRequest} from "firebase-functions/v2/https";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript
interface Quote {
  quote: string;
  author: string;
}
const quotes = [
  {
      quote: "The greatest glory in living lies not in never falling, but in rising every time we fall.",
      author: "Nelson Mandela"},
  {quote:"The way to get started is to quit talking and begin doing.",
      author: "Walt Disney"},
  { quote: "Your time is limited, don't waste it living someone else's life.",
      author: "Steve Jobs"}
];

const API_NINJAS_KEY = 'TSSofOsiVTK2O9ND6r2SyQ==KpSkV5JkLRwt2jiu';


export const quote = onRequest(async (req: any, res: any) => {
  const category = req.query.category ? req.query.category.toString() : '';

  let uri = 'https://api.api-ninjas.com/v1/quotes';
  if (category) {
    uri = `${uri}?category=${category}`;
  }

  try {
    const response = await axios.get(uri, {
      headers: { 'X-Api-Key': API_NINJAS_KEY },
    });

    if (response.status === 200) {
      const json = response.data[0];
      const quote: Quote = { quote: json.quote, author: json.author };
      res.status(200).send(quote);
    } else {
      const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
      res.status(200).send(randomQuote);
    }
  } catch (error) {
    const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
    res.status(200).send(randomQuote);
  }
});
