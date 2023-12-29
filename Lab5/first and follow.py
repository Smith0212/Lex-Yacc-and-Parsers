# Define the LL(1) grammar rules
grammar = {
    # 'S': ['abS', 'AB'],
    # 'A': ['e', 'ε'],
    # 'B': ['bC', 'ε'],
    # 'C': ['c']
    'S': ['AaAb', 'BbBa'],
    'A': ['ε'],
    'B': ['ε']
}

# Function to calculate FIRST sets
def calculate_first():
    first = {}
    for non_terminal in grammar.keys():
        first[non_terminal] = set()

    while True:
        updated = False
        for non_terminal, productions in grammar.items():
            for production in productions:
                # Case 1: If it's a terminal, add it to FIRST
                if production[0].islower() or production[0] == 'ε':
                    if production[0] not in first[non_terminal]:
                        first[non_terminal].add(production[0])
                        updated = True
                # Case 2: If it's a non-terminal, add FIRST of that non-terminal
                else:
                    for symbol in production:
                        if symbol == 'ε':
                            continue
                        if symbol in first[non_terminal]:
                            break
                        first[non_terminal].update(first[symbol])
                        if 'ε' not in first[non_terminal]:
                            updated = True
                            #first[non_terminal].add('ε')
                        else: 
                            first[non_terminal].remove('ε')
                            
                            
        if not updated:
            break

    return first

# Function to calculate FOLLOW sets
def calculate_follow(first):
    follow = {}
    for non_terminal in grammar.keys():
        follow[non_terminal] = set()

    follow['S'].add('$')  # '$' represents the end of input

    while True:
        updated = False
        for non_terminal, productions in grammar.items():
            for production in productions:
                for i, symbol in enumerate(production):
                    if symbol.isupper():
                        # Case 1: Add FIRST of the next symbol if it's not ε
                        if i < len(production) - 1:
                            next_symbol = production[i + 1]
                            if next_symbol.isupper():
                                follow[symbol].update(follow[next_symbol])
                            else:
                                follow[symbol].add(next_symbol)
                            if 'ε' in first[next_symbol]:
                                follow[symbol].update(first[next_symbol] - {'ε'})
                        # Case 2: Add FOLLOW of the left-hand side non-terminal
                        else:
                            follow[symbol].update(follow[non_terminal])
        if not updated:
            break

    return follow

if __name__ == "__main__":
    first_sets = calculate_first()
    follow_sets = calculate_follow(first_sets)

    print("FIRST Sets:")
    for non_terminal, first_set in first_sets.items():
        print(f"FIRST({non_terminal}) = {first_set}")

    print("\nFOLLOW Sets:")
    for non_terminal, follow_set in follow_sets.items():
        print(f"FOLLOW({non_terminal}) = {follow_set}")
