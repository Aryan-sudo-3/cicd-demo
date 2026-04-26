# ============================================
# Stage 1: builder
# Install dependencies in an isolated stage
# ============================================
FROM python:3.11-slim AS builder

WORKDIR /build

# Copy only requirements first (layer caching)
# If requirements.txt hasn't changed, this layer
# is reused on every build — saves time
COPY app/requirements.txt .

RUN pip install --upgrade pip && \
    pip install --prefix=/install -r requirements.txt

# ============================================
# Stage 2: final image
# Only copies what's needed — no pip, no cache
# ============================================
FROM python:3.11-slim AS final

WORKDIR /app

# Copy installed packages from builder stage
COPY --from=builder /install /usr/local

# Copy app code
COPY app/ .

# Don't run as root
RUN useradd -m appuser
USER appuser

EXPOSE 5000

CMD ["python", "main.py"]