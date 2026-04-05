import Reveal from 'reveal.js/dist/reveal.esm.js'; // Use the ESM build
import 'reveal.js/dist/reveal.css';
import 'reveal.js/dist/theme/white.css';
import './custom.css';

const deck = new Reveal({
  hash: true,       // optional: enables URL hash for slides
  center: true      // optional: vertically center slides
});

deck.initialize();

console.log("Reveal initialized"); // sanity check