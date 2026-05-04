# Basic predicates
p1(Word) :- poem(_, _, Words), member(Word, Words).
p2(PreviousWord, Word) :- poem(_, _, Words), append(_, [PreviousWord, Word|_], Words).
p3(PreviousWord, Word, NextWord) :- poem(_, _, Words), append(_, [PreviousWord, Word, NextWord|_], Words).

# Author-specific predicates
pc1(Word, Author) :- poem(Author, _, Words), member(Word, Words).
pc2(PreviousWord, Word, Author) :- poem(Author, _, Words), append(_, [PreviousWord, Word|_], Words).
pc3(PreviousWord, Word, NextWord, Author) :- poem(Author, _, Words), append(_, [PreviousWord, Word, NextWord|_], Words).

# Utility predicates
next_words(Word, L) :- findall(Next, p3(_, Word, Next), L).

# Count occurrences recursively
count_occ(_, [], 0).
count_occ(X, [X|T], Count) :- count_occ(X, T, Count1), Count is Count1 + 1.
count_occ(X, [Y|T], Count) :- X \= Y, count_occ(X, T, Count).

# Remove all occurrences of an element from a list
remove_all(_, [], []).
remove_all(X, [X|T], R) :- remove_all(X, T, R).
remove_all(X, [Y|T], [Y|R]) :- X \= Y, remove_all(X, T, R).

# Count occurrences of each unique element in a list
count_list([], []).
count_list([H|T], [H-Count|R]) :- count_occ(H, [H|T], Count), remove_all(H, T, NewT), count_list(NewT, R).

# Simple wrapper to get next word counts
next_word_counts(Word, Counts) :- next_words(Word, NextWords), count_list(NextWords, Counts).
next_word_counts_author(Author, Word, Counts) :- findall(Next, pc3(_, Word, Next, Author), NextWords), count_list(NextWords, Counts).

# Find the most frequent pair in a list of Word-Count pairs
most_frequent_pair([], _, _) :- fail.
most_frequent_pair([W-C], W, C).
most_frequent_pair([W1-C1, _-C2 | T], BW, BC) :- C1 >= C2, most_frequent_pair([W1-C1 | T], BW, BC).
most_frequent_pair([_-C1, W2-C2 | T], BW, BC) :- C1 < C2, most_frequent_pair([W2-C2 | T], BW, BC).

# Find the most frequent next word for a given word
most_frequent_next(Word, NextWord, Count) :- next_word_counts(Word, Counts), most_frequent_pair(Counts, NextWord, Count).
most_frequent_next_author(Author, Word, NextWord, Count) :- next_word_counts_author(Author, Word, Counts), most_frequent_pair(Counts, NextWord, Count).

# Find the most frequent word
most_frequent_word(Word, Count) :- findall(Word, p1(Word), Words), count_list(Words, Counts), most_frequent_pair(Counts, Word, Count).
most_frequent_word_author(Author, Word, Count) :- findall(Word, pc1(Word, Author), Words), count_list(Words, Counts), most_frequent_pair(Counts, Word, Count).

# Generate a new poem based on the most frequent next words
new_poem(Start, Length, Poem) :- poem(_, _, Words), append(_, [Start|_], Words), generate_poem(Start, 1, Length, Poem).
generate_poem(_, Count, MaxCount, []) :- Count > MaxCount.
generate_poem(Current, Count, MaxCount, [Current|Rest]) :- Count =< MaxCount, most_frequent_next(Current, Next, _), NewCount is Count + 1, generate_poem(Next, NewCount, MaxCount, Rest).

# Generate a new poem for a specific author
new_author_poem(Author, Start, Length, Poem) :- poem(Author, _, Words), append(_, [Start|_], Words), generate_author_poem(Author, Start, 1, Length, Poem).
generate_author_poem(_, _, Count, MaxCount, []) :- Count > MaxCount.
generate_author_poem(Author, Current, Count, MaxCount, [Current|Rest]) :- Count =< MaxCount, most_frequent_next_author(Author, Current, Next, _), NewCount is Count + 1, generate_author_poem(Author, Next, NewCount, MaxCount, Rest).
