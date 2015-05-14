include:
  - postfix

{% if 'sasl_passwd' in pillar.get('postfix', '') %}
/etc/postfix/sasl_passwd:
  file.managed:
    - source: salt://postfix/files/sasl_passwd
    - user: root
    - group: root
    - mode: 600
    - template: jinja

run-postmap:
  cmd.wait:
    - name: "/usr/sbin/postmap hash:/etc/postfix/sasl_passwd"
    - cwd: /
    - watch:
      - file: /etc/postfix/sasl_passwd
    - watch_in:
      - service: postfix

{% endif -%}
