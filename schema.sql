-- PostgreSQL schema for PQC Inductions
-- Table: '2026-27 QCom'
-- Note: Identifier has spaces, hyphens, and digits, so double quotes are required.

CREATE TABLE IF NOT EXISTS "2026-27 QCom" (
    id SERIAL PRIMARY KEY,
    invite_code VARCHAR(6) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    times_viewed INT DEFAULT 0,
    last_viewed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_qcom_invite_code ON "2026-27 QCom" (UPPER(invite_code));

-- Example insert (for testing):
-- INSERT INTO "2026-27 QCom" (invite_code, name) VALUES ('TEST01', 'Sample Member')
-- ON CONFLICT (invite_code) DO NOTHING;
