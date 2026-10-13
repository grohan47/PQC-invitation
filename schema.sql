-- PostgreSQL schema for PQC Inductions
-- Table: '2026-27 QCom'

-- Function to generate unique 6-character uppercase alphabet-only codes
CREATE OR REPLACE FUNCTION generate_invite_code()
RETURNS VARCHAR(6) AS $$
DECLARE
    chars text := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    result text;
    done boolean := false;
BEGIN
    WHILE NOT done LOOP
        SELECT string_agg(substr(chars, floor(random() * 26 + 1)::int, 1), '')
        INTO result
        FROM generate_series(1, 6);

        IF NOT EXISTS (SELECT 1 FROM "2026-27 QCom" WHERE invite_code = result) THEN
            done := true;
        END IF;
    END LOOP;
    RETURN result;
END;
$$ LANGUAGE plpgsql VOLATILE;

-- Table definition with auto-generated 6-letter invite code
CREATE TABLE IF NOT EXISTS "2026-27 QCom" (
    id SERIAL PRIMARY KEY,
    invite_code VARCHAR(6) UNIQUE NOT NULL DEFAULT generate_invite_code(),
    name VARCHAR(255) NOT NULL,
    times_viewed INT DEFAULT 0,
    last_viewed_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_qcom_invite_code ON "2026-27 QCom" (UPPER(invite_code));

-- Example: You can now insert by name only! The 6-letter code will be automatically generated:
-- INSERT INTO "2026-27 QCom" (name) VALUES ('Candidate Name') RETURNING id, invite_code, name;
