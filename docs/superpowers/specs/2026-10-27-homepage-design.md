# Academic homepage redesign

The user selected a Jon Barron style academic homepage and requested implementation on an independent branch for review. Preserve all existing biography, research interests, news, publications, patents, teaching, services, talks, awards, portrait, and profile links. Do not merge or change the production Pages source.

Use the existing Jekyll/GitHub Pages stack, a white background, readable sans-serif text, blue links, and a centered 1040px content column (widened from 860px following owner review). Place the biography beside the portrait on desktop and stack them on small screens. Publications are text-only; retain every field and link, including accepted papers without a PDF. Keep the existing section order. Highlight award names with the existing deep rust accent and bold only the quoted titles in Invited Talks.

A top-right Menu disclosure links to every section. It works with keyboard input and without JavaScript. News shows the newest 10 entries in the existing reverse-chronological order, with an accessible native disclosure for the complete remaining archive. JavaScript only enhances menu dismissal.

Alternatives considered: replace the site with a JavaScript framework (unnecessary dependencies and deployment changes); retain Jekyll and replace only the presentation (selected implementation because content is already structured). Use the supplied reference directly; no new visual assets or generated mockups are needed.

Validate the real GitHub Pages dependency bundle, content preservation, non-root asset paths, desktop/mobile layout, menu interaction, news expansion, keyboard operation, and JavaScript-disabled behavior. Provide a branch-only Actions build artifact and local preview; if possible provide a separate hosted preview. Never invoke a production Pages deployment.

## Owner content and profile revisions

Remove the Wu Yuzhang Young Scholar entry from Awards. Link the NAS paper to https://www.nature.com/articles/s44387-026-00156-5 and remove its Accepted note. Replace research interests with Data Privacy and Security, Federated Learning, Private Data Federation, LLM Privacy, and Agent Memory Access Control. Move contact/profile links directly under the name. On desktop, align the portrait with the biography below the heading block; on mobile, show the heading/contact block, portrait, then biography. Use the faculty portrait from https://info.ruc.edu.cn/images/2024-09/99d7b10b3ef144dfb8fc1b46d1154a46.jpg, identified on the faculty page supplied by the owner.
