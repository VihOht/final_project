import re

def tokenizer(text):
    """
    Tokenizes the input into a list of words,
    removing ponctuation and converting to lowercase.
    """
    return re.findall(r'[a-zA-Z]+', text.lower())

def sanitize(text):
    """
    Sanitizes the input by removing ponctuation and converting to lowercase.
    """
    return re.sub(r'[^\w\s]', '', text.lower()).replace(' ', '_')


def read_poem(file_path):
    """
    Reads the content of a file and returns:
      - the author sanitized (the first line of the file)
      - the title sanitized (the second line of the file)
      - the words of the poem (the rest of the file) as a list of words.
    """
    with open(file_path, 'r') as file:
        lines = file.readlines()
        line1 = lines[0] if len(lines) > 0 else ""
        if "AUTHOR:" in line1:
            author = sanitize(line1.split("AUTHOR:")[1].strip())
        else:
            author = ""
        line2 = lines[1] if len(lines) > 1 else ""
        if "TITLE:" in line2:
            title = sanitize(line2.split("TITLE:")[1].strip())
        else:
            title = ""
        words = tokenizer(" ".join(lines[2:])) if len(lines) > 2 else []
        return author, title, words