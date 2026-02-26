.PHONY: setup dev dev-detached stop logs status update clean

setup:
	bash scripts/setup.sh

dev:
	docker compose up --build

dev-detached:
	docker compose up --build -d

stop:
	docker compose down

logs:
	docker compose logs -f

status:
	@echo "==> playwright-http (8932)"
	@curl -sf http://localhost:8932/health && echo " OK" || echo " DOWN"
	@echo "==> backend (8000)"
	@curl -sf http://localhost:8000/health && echo " OK" || echo " DOWN"
	@echo "==> frontend (3001)"
	@curl -sf http://localhost:3001 > /dev/null && echo " OK" || echo " DOWN"

update:
	@for dir in checkmate checkmate-ui playwright-http; do \
		if [ -d "$$dir" ]; then \
			echo "==> Updating $$dir..."; \
			git -C "$$dir" pull; \
		else \
			echo "==> $$dir not found — run 'make setup' first"; \
		fi; \
	done

clean:
	docker compose down -v
