#!/bin/bash

# Automated Molecular Docking Pipeline using AutoDock Vina
# Author: Faiza

# Set paths
RECEPTOR="receptor.pdbqt"
LIGAND_DIR="ligands"
OUTPUT_DIR="docking_results"
CONFIG="config.txt"
LOG_DIR="logs"

# Create necessary directories
mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

# Loop through all ligands
for LIGAND in "$LIGAND_DIR"/*.pdbqt; do
    LIGAND_NAME=$(basename "$LIGAND" .pdbqt)
    OUTPUT_FILE="$OUTPUT_DIR/${LIGAND_NAME}_out.pdbqt"
    LOG_FILE="$LOG_DIR/${LIGAND_NAME}.log"

    echo "Docking $LIGAND_NAME..."
    vina --receptor "$RECEPTOR" --ligand "$LIGAND" \
         --config "$CONFIG" --out "$OUTPUT_FILE" --log "$LOG_FILE"
    echo "Completed: $LIGAND_NAME"
done

echo "Docking process completed. Results saved in $OUTPUT_DIR."

