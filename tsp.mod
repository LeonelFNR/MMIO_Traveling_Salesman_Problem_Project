set NODES;
param dist {NODES, NODES};

# Decision variables: x[i,j] = 1 if edge (i,j) is selected.
# Defined for i < j to handle symmetry (undirected graph).
var x {i in NODES, j in NODES: i < j} >= 0, <= 1;

# Objective: Minimize total distance
minimize Total_Cost:
    sum {i in NODES, j in NODES: i < j} dist[i,j] * x[i,j];

# Constraint: Degree = 2 for every node (Assignment / 2-Matching)
# We sum x[i,j] if j > i, and x[j,i] if j < i
subject to Degree {i in NODES}:
    sum {j in NODES: j > i} x[i,j] + sum {j in NODES: j < i} x[j,i] = 2;

# --- Subtour Elimination Constraints (Section c & d) ---
# These are initially commented out. We enable them manually in the .run file
# or by uncommenting them here after identifying the subtours.

# Manual Cut 1 (Section c) - Example for Cluster A
# subject to Subtour_ClusterA:
#    x[1,2] + x[1,4] + x[1,12] + x[2,4] + x[2,12] + x[4,12] <= 3;

# Manual Cut 2 (Section d) - Example for Cluster B
# subject to Subtour_ClusterB:
#    x[5,8] + x[5,13] + x[5,15] + x[8,13] + x[8,15] + x[13,15] <= 3;