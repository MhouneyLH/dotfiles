# nerd-dictation text processing: spoken punctuation, "I" and sentence capitalization.
# Loaded from ~/.config/nerd-dictation/nerd-dictation.py
import re

# Spoken phrase -> text. Punctuation attaches to the previous word.
PUNCTUATION = {
    "comma": ",",
    "period": ".",
    "full stop": ".",
    "question mark": "?",
    "exclamation mark": "!",
    "exclamation point": "!",
    "colon": ":",
    "semicolon": ";",
}
# Words the model often gets wrong
REPLACEMENTS = {
    "claude code": "Claude Code",
    "claude": "Claude",
    "github": "GitHub",
    "kubernetes": "Kubernetes",
    "open tofu": "OpenTofu",
    "ansible": "Ansible",
}


def nerd_dictation_process(text):
    for spoken, written in PUNCTUATION.items():
        text = re.sub(r"\s*\b" + re.escape(spoken) + r"\b", written, text)
    for spoken, written in REPLACEMENTS.items():
        text = re.sub(r"\b" + re.escape(spoken) + r"\b", written, text)
    text = re.sub(r"\bi\b", "I", text)
    text = re.sub(r"\bi(['’])(m|ll|ve|d)\b", lambda m: "I" + m.group(1) + m.group(2), text)
    text = re.sub(r"(^|[.!?]\s+)([a-z])", lambda m: m.group(1) + m.group(2).upper(), text)
    return text
