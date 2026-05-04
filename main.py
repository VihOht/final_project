from utils import read_poem
from pathlib import Path
from pyswip import Prolog
from argparse import ArgumentParser

HOME = Path(__file__).parent
POEMS_DIR = HOME / "poems"
PL_W_FILE = HOME / "main.pl"
PL_PREDICATES_FILE = HOME / "predicates.pl"
PL_QUERIES_FILE = HOME / "queries.pl"

def load_poems():
    poems = list(POEMS_DIR.glob("*.txt"))
    with open(PL_W_FILE, 'w') as pl_file:
        pl_file.write(":- discontiguous poem/3.\n\n")
        for poem in poems:
            author, title, words = read_poem(poem)
            print(f"Author: {author}")
            print(f"Title: {title}")
            print(f"Words: {words[0:10]}...")  # Print the first 10 words of the poem
            pl_file.write(f"poem({author}, {title}, {words}).\n")

def main(debug=False):
    load_poems()
    load_predicates()
    if debug:
        test()
    else:
        run_query()

def run_query():
    prolog = Prolog()
    prolog.consult(str(PL_W_FILE))
    
    with open(PL_QUERIES_FILE, 'r') as pl_file:
        queries = pl_file.readlines()
    main_query = ""
    show_once = False
    for query in queries:
        query = query.strip()
        if not query or query.startswith('#'):
            continue
        if "$once" in query:
            show_once = True
            query = query.replace("$once", "").strip()
        if not query.endswith('.'):
            main_query += query + " "
            continue
        main_query += query
        if not main_query:
            continue
        print(f"Executing query: {main_query}")
        try:
            results = list(prolog.query(main_query))
            if show_once:
                if results:
                    print(results[0])
                else:
                    print("No results found.")
                show_once = False
            else:
                if results:
                    for result in results:
                        print(result)
                else:
                    print("No results found.")
        except Exception as e:
            print(f"Error executing query: {e}")
        finally:
            main_query = ""

def load_predicates():
    lines = []
    with open(PL_PREDICATES_FILE, 'r') as pl_file:
        lines = pl_file.readlines()
    
    with open(PL_W_FILE, 'a') as pl_file:
        pl_file.write("\n")
        for line in lines:
            if line.strip() and not line.strip().startswith('#'):
                pl_file.write(line)

def test():
    prolog = Prolog()
    try:
        prolog.consult(str(PL_W_FILE))
    except Exception as e:
        print(f"Error consulting Prolog file: {e}")
        return

    while (query := input("Enter a Prolog query (or 'exit' to quit): ").strip()) != 'exit':
        while not query.endswith('.'):
            query += ' ' + input("... ").strip()
        print(f"Executing query: {query}")
        try:
            print("Results:")
            results = list(prolog.query(query))
            if results:
                for result in results:
                    print(result)
            else:
                print("No results found.")
        except Exception as e:
            print(f"Error executing query: {e}")

if __name__ == "__main__":
    args = ArgumentParser(description="Load poems into Prolog and execute queries.")
    args.add_argument('--test', action='store_true', help="Run the interactive Prolog query interface.")
    args = args.parse_args()
    main(debug=args.test)