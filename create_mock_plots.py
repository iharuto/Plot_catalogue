#!/usr/bin/env python3
"""
Create mock PNG files to simulate R plot outputs
Since R is not available, we'll create placeholder images with plot descriptions
"""

import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
from matplotlib.patches import FancyBboxPatch
import os

def create_sankey_mockup():
    """Create a mockup of the SankeyArrow plot"""
    fig, ax = plt.subplots(figsize=(10, 6))
    
    # Draw flow diagram elements
    # Input funnel
    ax.add_patch(patches.Polygon([(-0.4, 0), (-0.4, 1), (-0.32, 0.5)], 
                                closed=True, fill=True, color='lightblue', alpha=0.7))
    
    # Flow segments
    colors = ['red', 'green', 'blue', 'orange', 'purple']
    y_positions = [0.8, 0.6, 0.4, 0.2, 0.1]
    widths = [0.3, 0.25, 0.2, 0.15, 0.1]
    
    for i, (y, width, color) in enumerate(zip(y_positions, widths, colors)):
        # Flow rectangles
        rect = FancyBboxPatch((i*0.3, y-width/2), 0.25, width, 
                             boxstyle="round,pad=0.02", 
                             facecolor=color, alpha=0.6, edgecolor='black')
        ax.add_patch(rect)
        
        # Labels
        ax.text(i*0.3 + 0.35, y, f'Process {chr(65+i)}\n({int((1-i*0.1)*300)})', 
               ha='left', va='center', fontsize=10, weight='bold')
    
    ax.set_xlim(-0.6, 2)
    ax.set_ylim(-0.1, 1.1)
    ax.set_title('SankeyArrow - Flow Diagram Visualization\n(Advanced Level)', 
                fontsize=14, weight='bold', pad=20)
    ax.text(0.5, -0.05, 'Complex geometric flow layout with proportional segments', 
           ha='center', transform=ax.transAxes, style='italic')
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('figure/advanced_1.png', dpi=300, bbox_inches='tight')
    plt.close()

def create_eeg_mockup():
    """Create a mockup of the EEG PCA plot"""
    fig, ax = plt.subplots(figsize=(10, 8))
    
    # Generate mock PCA scatter points
    np.random.seed(42)
    n_points = 200
    x = np.random.normal(0, 1, n_points)
    y = np.random.normal(0, 1, n_points)
    colors = np.random.choice(['red', 'blue', 'green', 'orange'], n_points)
    
    # Scatter plot
    scatter = ax.scatter(x, y, c=colors, alpha=0.6, s=30)
    
    # Add some "EEG traces" - simplified wavy lines
    for i in range(12):
        angle = i * 2 * np.pi / 12
        center_x = 2 * np.cos(angle)
        center_y = 2 * np.sin(angle)
        
        # Create wavy line
        t = np.linspace(0, 2*np.pi, 50)
        trace_x = center_x + 0.3 * t/np.pi - 0.3
        trace_y = center_y + 0.1 * np.sin(5*t)
        
        # Color by amplitude
        line_colors = plt.cm.RdBu(0.5 + 0.3 * np.sin(3*t))
        for j in range(len(t)-1):
            ax.plot([trace_x[j], trace_x[j+1]], [trace_y[j], trace_y[j+1]], 
                   color=line_colors[j], linewidth=1)
        
        # Add epoch label
        ax.text(center_x * 1.3, center_y * 1.3, f'{i+1}', 
               fontsize=8, ha='center', va='center', weight='bold')
    
    ax.set_xlim(-4, 4)
    ax.set_ylim(-4, 4)
    ax.set_title('plot_PCA_raw_EEG_mouse - EEG Latent Space Visualization\n(Advanced Level)', 
                fontsize=14, weight='bold', pad=20)
    ax.text(0.5, -0.05, 'Multi-layer plot: PCA scatter + EEG traces + temporal dynamics', 
           ha='center', transform=ax.transAxes, style='italic')
    
    # Add colorbar
    cbar = plt.colorbar(scatter, ax=ax, shrink=0.6)
    cbar.set_label('log(Sigma amplitude)', rotation=270, labelpad=20)
    
    plt.tight_layout()
    plt.savefig('figure/advanced_2.png', dpi=300, bbox_inches='tight')
    plt.close()

def create_tree_mockup():
    """Create a mockup of the circular tree plot"""
    fig, ax = plt.subplots(figsize=(10, 10))
    
    # Create circular tree structure
    center = (0, 0)
    radius_levels = [0, 1, 2, 3]
    
    # Root node
    ax.scatter([0], [0], s=200, c='red', alpha=0.8, edgecolors='black')
    ax.text(0, 0, 'Root', ha='center', va='center', fontsize=10, weight='bold')
    
    # Level 1 nodes
    level1_angles = np.linspace(0, 2*np.pi, 4, endpoint=False)
    level1_names = ['Cortex', 'Subcortex', 'Brainstem', 'Cerebellum']
    level1_colors = ['lightcoral', 'lightgreen', 'lightblue', 'lightyellow']
    
    for i, (angle, name, color) in enumerate(zip(level1_angles, level1_names, level1_colors)):
        x = radius_levels[1] * np.cos(angle)
        y = radius_levels[1] * np.sin(angle)
        
        # Draw edge from root
        ax.plot([0, x], [0, y], 'gray', alpha=0.6, linewidth=2)
        
        # Node
        ax.scatter([x], [y], s=150, c=color, alpha=0.8, edgecolors='black')
        ax.text(x*1.2, y*1.2, name, ha='center', va='center', fontsize=9, weight='bold')
        
        # Level 2 nodes
        sub_angles = angle + np.array([-0.3, 0, 0.3])
        sub_names = [f'{name[:3]}_A', f'{name[:3]}_B', f'{name[:3]}_C']
        
        for j, (sub_angle, sub_name) in enumerate(zip(sub_angles, sub_names)):
            sub_x = radius_levels[2] * np.cos(sub_angle)
            sub_y = radius_levels[2] * np.sin(sub_angle)
            
            # Edge
            ax.plot([x, sub_x], [y, sub_y], 'gray', alpha=0.4, linewidth=1)
            
            # Node
            ax.scatter([sub_x], [sub_y], s=80, c=color, alpha=0.6, edgecolors='gray')
            ax.text(sub_x*1.1, sub_y*1.1, sub_name, ha='center', va='center', fontsize=7)
    
    ax.set_xlim(-4, 4)
    ax.set_ylim(-4, 4)
    ax.set_aspect('equal')
    ax.set_title('make_template_tree - Circular Hierarchical Network\n(Intermediate Level)', 
                fontsize=14, weight='bold', pad=20)
    ax.text(0.5, -0.05, 'ggraph circular tree layout with node/edge customization', 
           ha='center', transform=ax.transAxes, style='italic')
    ax.axis('off')
    
    plt.tight_layout()
    plt.savefig('figure/intermediate_1.png', dpi=300, bbox_inches='tight')
    plt.close()

if __name__ == "__main__":
    # Create figure directory if it doesn't exist
    os.makedirs('figure', exist_ok=True)
    
    print("Creating mock plot visualizations...")
    create_sankey_mockup()
    print("✓ Created advanced_1.png (SankeyArrow)")
    
    create_eeg_mockup()
    print("✓ Created advanced_2.png (EEG PCA)")
    
    create_tree_mockup()
    print("✓ Created intermediate_1.png (Tree Network)")
    
    print("\nAll mock plots created successfully!")