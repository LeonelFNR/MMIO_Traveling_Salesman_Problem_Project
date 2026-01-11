set NODES;
param dist {NODES, NODES};

# --- DECISION VARIABLES ---
# Binary variable (relaxed to continuous in .run)
var x {i in NODES, j in NODES: i < j} binary;

# --- OBJECTIVE & CONSTRAINTS ---
minimize Total_Cost:
    sum {i in NODES, j in NODES: i < j} dist[i,j] * x[i,j];

subject to Degree {i in NODES}:
    sum {j in NODES: j > i} x[i,j] + sum {j in NODES: j < i} x[j,i] = 2;

# --- HEURISTIC PARAMS (Used in Section a) ---
param n default card(NODES);
param tour {1..n+1};
param visited {NODES} default 0;
param best_cost;
param current_node;
param next_node;
param min_dist;
param improved;
param tmp;

# --- DYNAMIC CUTS SETUP (Crucial for Automatic Section b) ---
# Set to store cut IDs found by the script
set CUTS; 

# Map each cut ID to the nodes forming the subtour
set SUBTOUR_NODES {CUTS} within NODES;

# Generic Constraint: sum(edges in S) <= |S| - 1
subject to Dynamic_SEC {k in CUTS}:
    sum {i in SUBTOUR_NODES[k], j in SUBTOUR_NODES[k]: i < j} x[i,j] 
    <= card(SUBTOUR_NODES[k]) - 1;