;; mainnet https://explorer.stacks.co/txid/SP1W7X92JG1BYPKG15KTS6398XN4D4HJP9TTXMQ38.multi-send?chain=mainnet

;; multi-send

(define-trait sip010-transferable-trait
	(
		(transfer (uint principal principal (optional (buff 34))) (response bool uint))
	)
)

(define-private (multi-send-iter (data {amount: uint, sender: principal, recipient: principal}) (sip010-token <sip010-transferable-trait>))
	(begin
		(unwrap-panic (contract-call? sip010-token transfer (get amount data) (get sender data) (get recipient data) none))
		sip010-token
	)
)

(define-public (multi-send (data (list 200 {amount: uint, sender: principal, recipient: principal})) (sip010-token <sip010-transferable-trait>))
	(begin
		(fold multi-send-iter data sip010-token)
		(ok true)
	)
)

;; Thanks to Marvin
;; Stacks MultiSender https://btc.stx-multisender.com
