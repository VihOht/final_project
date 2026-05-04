# Poetry Analysis with Prolog

A Python project that reads poems and performs queries using Prolog predicates.

## Descrição | Description

This project provides for the generation and analysis of poems from games or real sources. It provides functions that generate poems through word frequency. The project reads poems from the `poems/` folder, creates a Prolog database, executes predicates from `predicates.pl`, and runs queries from the `queries.pl` file. If you use the `--debug` argument, you can create your own queries in real time.

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

## Running the Program

Run the main program:
```bash
python main.py
```

### Options

- **Normal mode** (default): Processes poems and runs queries defined in `queries.pl`
  ```bash
  python main.py
  ```

- **Debug mode**: Runs tests
  ```bash
  python main.py --debug
  ```

## How It Works | Como Funciona

1. **main.py** - Entry point that:
   - Loads all `.txt` files from the `poems/` directory
   - Analyzes word frequency in each poem
   - Generates `main.pl` with poem facts containing tokenized words
   - Executes Prolog queries and displays results

2. **poems/** - Directory containing poem text files (one poem per file from games or other sources)

3. **queries.pl** - Defines Prolog queries to run against the poems database
   - Use `$once` prefix to show only the first result
   - Queries are executed against the Prolog database

4. **predicates.pl** - Contains Prolog predicates for analyzing poems:
   - Word frequency analysis
   - Word occurrence patterns
   - Author-based queries

5. **utils.py** - Utility functions for:
   - Reading poem files
   - Parsing and tokenizing poem content

6. **main.pl** - Auto-generated Prolog database with poem facts

## Example Usage

The program reads poems and can query them using Prolog. Queries are defined in `queries.pl` and executed when you run the program.

## Debug Mode | Modo Debug

Use the `--test` flag to enter interactive mode where you can create and test your own Prolog queries in real time:

```bash
python main.py --test
```

This allows you to experiment with predicates and test theories about the poems without modifying the `queries.pl` file.

