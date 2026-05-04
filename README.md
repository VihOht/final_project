# Poetry Analysis with Prolog

A Python project that reads poems and performs queries using Prolog predicates.

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

## How It Works

1. **main.py** - Entry point that:
   - Loads all `.txt` files from the `poems/` directory
   - Generates `main.pl` with poem facts
   - Executes Prolog queries

2. **poems/** - Directory containing poem text files (one poem per file)

3. **queries.pl** - Defines Prolog queries to run against the poems

4. **predicates.pl** - Contains Prolog predicates for analysis

5. **utils.py** - Utility functions for reading and processing poems

## Example Usage

The program reads poems and can query them using Prolog. Queries are defined in `queries.pl` and executed when you run the program.

