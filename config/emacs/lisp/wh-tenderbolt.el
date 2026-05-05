;;; wh-tenderbolt.el --- -*- lexical-binding: t -*-

;;; Commentary: Extensions for interacting with Tenderbolt tools

;;; Code:

(when (string-equal (system-name) "silverwing")
  (use-package sql
    :ensure nil
    :config
    (add-to-list 'sql-connection-alist '("tenderbolt-dev"
                                         (sql-product 'postgres)
                                         (sql-server "127.0.0.1")
                                         (sql-port 54322)
                                         (sql-user "postgres")
                                         (sql-password "postgres")
                                         (sql-database "postgres")))))

(provide 'wh-tenderbolt)

;;; wh-tenderbolt.el ends here
