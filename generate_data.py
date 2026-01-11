import random
import math

def generate_tsp_dataset(num_nodes=15, grid_size=100, seed=None):
    """
    Generates a TSP dataset in AMPL .dat format.
    
    Args:
        num_nodes (int): Number of cities to generate.
        grid_size (int): Size of the coordinate grid (0 to grid_size).
        seed (int): Random seed for reproducibility (optional).
    """
    
    # Set random seed if provided
    if seed is not None:
        random.seed(seed)

    # ---------------------------------------------------------
    # 1. Generate Random Coordinates
    # ---------------------------------------------------------
    coords = {}
    for i in range(1, num_nodes + 1):
        # Generate random (x, y) coordinates within the grid
        coords[i] = (random.randint(0, grid_size), random.randint(0, grid_size))

    # ---------------------------------------------------------
    # 2. Print AMPL Data Header
    # ---------------------------------------------------------
    print("data;")
    print("")
    
    # Create the list of nodes string (e.g., "1 2 3 ... 15")
    nodes_str = " ".join(str(i) for i in range(1, num_nodes + 1))
    
    # Define the SET of nodes
    print(f"set NODES := {nodes_str};")
    print("")
    
    # ---------------------------------------------------------
    # 3. Calculate and Print Distance Matrix
    # ---------------------------------------------------------
    # Header of the matrix parameters
    print(f"param dist : {nodes_str} :=")
    
    for i in range(1, num_nodes + 1):
        # Start the row with the node ID
        row_output = f"{i:<3}" 
        
        for j in range(1, num_nodes + 1):
            if i == j:
                # Distance to self is 0
                dist = 0
            else:
                # Calculate Euclidean distance: sqrt((x2-x1)^2 + (y2-y1)^2)
                x1, y1 = coords[i]
                x2, y2 = coords[j]
                exact_dist = math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
                
                # Round to the nearest integer as per TSP convention
                dist = int(round(exact_dist))
            
            # Format the distance with padding for alignment
            row_output += f" {dist:>3}"
            
        # Print the full row
        print(row_output)
    
    # End of data command
    print(";")

# =========================================================
# Main Execution
# =========================================================
if __name__ == "__main__":
    # Change 'num_nodes' or 'seed' to create different maps
    # Using a fixed seed ensures you get the same map every time you run it
    generate_tsp_dataset(num_nodes=15, grid_size=100, seed=42)