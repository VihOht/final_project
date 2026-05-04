# Simple Queries
# Poems by a specific author
poem(Author, Title, _).

# Most common word
most_frequent_word(Word, Count).

# Most common word for a specific author
poem(Author, _, _),
most_frequent_word_author(Author, Word, Count).

# Most frequent next word for a given word
most_frequent_next(the, NextWord, Count). $once
most_frequent_next(love, NextWord, Count). $once

# Generate a new poem based on the most frequent next words
new_poem(the, 10, Poem). $once
new_poem(love, 20, Poem). $once
new_poem(the, 20, Poem). $once

# Generate a new poem for a specific author
new_author_poem(natsuki, the, 10, Poem). $once
new_author_poem(yuri, love, 20, Poem). $once