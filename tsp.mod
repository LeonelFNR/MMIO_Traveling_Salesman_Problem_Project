set NODES;
param dist {NODES, NODES};

# --- OPTIMIZATION MODEL VARIABLES ---
# x[i,j] is 1 if edge (i,j) is used. Defined for i < j to handle symmetry.
var x {i in NODES, j in NODES: i < j} binary;

# Objective: Minimize total distance
minimize Total_Cost:
    sum {i in NODES, j in NODES: i < j} dist[i,j] * x[i,j];

# Constraints: Degree of every node must be 2
subject to Degree {i in NODES}:
    sum {j in NODES: j > i} x[i,j] + sum {j in NODES: j < i} x[j,i] = 2;

# --- HEURISTIC PARAMETERS (Used in tsp.run) ---
param n default card(NODES);
param tour {1..n+1};       # Array to store the sequence of nodes
param visited {NODES} default 0;
param best_cost;
param current_node;
param next_node;
param min_dist;
param improved;
param tmp;