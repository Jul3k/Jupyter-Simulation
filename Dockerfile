FROM quay.io/jupyter/base-notebook:latest

# Install system packages (optional)
USER root
RUN apt-get update && \
    apt-get install -y gmsh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to jovyan user
USER $NB_UID

# Install Python packages
RUN pip install --no-cache-dir numpy pandas matplotlib scikit-learn pygmsh control jupyterlab_rise ipympl sympy scipy scikit-fem[all]

# Default to classic Notebook interface instead of JupyterLab
ENV DOCKER_STACKS_JUPYTER_CMD=notebook
