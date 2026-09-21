#!/bin/sh
set -e
python3 - <<'PY'
import os, re
from pathlib import Path
p = Path('config.env')
t = p.read_text() if p.exists() else ''

def setv(text, key):
    val = os.environ.get(key, '')
    if not val:
        return text
    if re.search(rf'^{key}=', text, re.M):
        return re.sub(rf'^{key}=.*$', f'{key}={val}', text, count=1, flags=re.M)
    return text.rstrip() + '\n' + f'{key}={val}\n'

for k in ('SESSION', 'OWNER_NUMBER', 'DEVICE_MODE'):
    t = setv(t, k)
p.write_text(t)
print('[boot] injected:', {k: bool(os.environ.get(k)) for k in ('SESSION', 'OWNER_NUMBER', 'DEVICE_MODE')})
PY
exec npm start
