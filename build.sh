#!/bin/bash
export NEXT_PUBLIC_BACKEND_URL='http://backend:8000/api'
export NEXT_PUBLIC_SUPABASE_ANON_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwaGVrbmRsYmtyYWd0cm1penZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzODY5NzQsImV4cCI6MjA2Mzk2Mjk3NH0.GOMWk24NMx99h_295YD1nQBz73a085oPmJCV75XrAu0'
export NEXT_PUBLIC_SUPABASE_URL='https://vphekndlbkragtrmizvq.supabase.co'
export NEXT_PUBLIC_URL='http://localhost:3000'
docker compose -f ./docker-compose.yaml build
