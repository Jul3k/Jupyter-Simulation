FROM quay.io/jupyter/base-notebook:latest

# Install system packages (optional)
USER root
RUN apt-get update && \
    apt-get install -y gmsh texlive texlive-latex-extra texlive-fonts-recommended dvipng cm-super && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Remobe default work dir
RUN rm -rf /home/jovyan/work

# Switch back to jovyan user
USER $NB_UID

# Install Python packages
RUN pip install --no-cache-dir latex numpy pandas matplotlib scikit-learn pygmsh control jupyterlab_rise ipympl sympy scipy scikit-fem[all]

# --- NEW: Set Matplotlib global defaults ---
RUN mkdir -p /home/jovyan/.config/matplotlib && \
    echo "text.usetex: True" > /home/jovyan/.config/matplotlib/matplotlibrc

COPY --chown=${NB_USER}:${NB_USER} ./Vorlesung ${HOME}/Vorlesung

# Default to classic Notebook interface instead of JupyterLab
ENV DOCKER_STACKS_JUPYTER_CMD=notebook
