from collections import Counter
import re

with open('./inputs/07.txt') as f:
    instructions = f.readlines()

words = re.compile(r'\w+')
weights = {}
children = {}

for line in instructions:
    node, weight, *kids = re.findall(words, line)
    weights[node] = int(weight)
    children[node] = kids

all_nodes = set(weights)
all_kids = {kid for kids in children.values() for kid in kids}
root = (all_nodes - all_kids).pop()
print(root)


def find_offsprings_weights(node):
    kids_weights = [find_offsprings_weights(kid) for kid in children[node]]
    unique_weights = Counter(kids_weights).most_common()
    if len(unique_weights) == 2:
        (correct_total, _), (wrong_total, _) = unique_weights
        difference = correct_total - wrong_total
        wrong_node = children[node][kids_weights.index(wrong_total)]
        wrong_weight = weights[wrong_node]
        print(wrong_weight + difference)
        return weights[node] + sum(kids_weights) + difference
    return weights[node] + sum(kids_weights)


find_offsprings_weights(root)
