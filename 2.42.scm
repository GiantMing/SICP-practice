(define accumulate fold-right)


(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))


; 生成(1 2 3 4 5 6 .... n)
(define (enumerate-interval m n)
    (if (> m n) '()
        (cons m (enumerate-interval (+ m 1) n))))


; 
(define empty-board '())


(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter 
                (lambda (positions) (safe? k positions))
                (flatmap 
                    (lambda (rest-of-queens)
                        (map (lambda (new-row)
                            (adjoin-position new-row k rest-of-queens))
                            (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
        (queen-cols board-size))



(define (safe? k position)
    (iter-check (car position) 
                (cdr position)
                 1))

(define (iter-check row-of-new-queen rest-of-queens i)
    (if (null? rest-of-queens)
        #t
        (let ((row-of-current-queen (car rest-of-queens)))
            (if (or (= row-of-new-queen row-of-current-queen)
                    (= row-of-new-queen (+ i row-of-current-queen))
                    (= row-of-new-queen (- row-of-current-queen i)))
                #f
                (iter-check row-of-new-queen 
                            (cdr rest-of-queens)
                            (+ i 1))))))




; (for-each (lambda (n) 
;     (display n)
;     (newline))
; (queens 4))














