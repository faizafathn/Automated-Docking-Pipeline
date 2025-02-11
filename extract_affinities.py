import os
import sys
import pandas as pd

def extract_affinity(log_file):
    with open(log_file, 'r') as file:
        for line in file:
            if line.strip().startswith('-----'):
                next(file)
                affinity_line = next(file).split()
                return float(affinity_line[1]) if affinity_line else None
    return None

def process_logs(log_dir):
    results = []
    for log_file in os.listdir(log_dir):
        if log_file.endswith(".log"):
            ligand_name = log_file.replace(".log", "")
            affinity = extract_affinity(os.path.join(log_dir, log_file))
            if affinity is not None:
                results.append((ligand_name, affinity))

    df = pd.DataFrame(results, columns=["Ligand", "Affinity (kcal/mol)"])
    df.to_csv("docking_affinities.csv", index=False)
    print("Binding affinities saved to docking_affinities.csv")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 extract_affinities.py <log_directory>")
        sys.exit(1)
    log_directory = sys.argv[1]
    process_logs(log_directory)

