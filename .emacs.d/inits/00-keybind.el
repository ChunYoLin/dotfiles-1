;; C-h で Backspace
(global-set-key "\C-h" 'delete-backward-char)

;; バイトコンパイル用のキーバインド登録
(global-set-key (kbd "C-C C-C") 'byte-compile-file)

;; C-x n で使い捨てバッファを開く
(defun generate-temporary-buffer ()
  (interactive)
  (switch-to-buffer
    (generate-new-buffer "*untitled*")))
(global-set-key (kbd "C-x n") 'generate-temporary-buffer)

;; C-w の挙動をシェルに寄せる
;; from http://qiita.com/k_ui/items/e6978008253ba70c037c
(defun backward-kill-word-or-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))
(global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)
