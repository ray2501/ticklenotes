package require tdbc::postgres

proc getAllNotes {} {
    set rows {}

    tdbc::postgres::connection create db -user danilo -password danilo -port 5432
    set stmt [db prepare {select * from Notes order by created}]
    $stmt execute
    set rows [$stmt allrows -as lists]

    $stmt close
    db close

    return $rows
}

proc getNote {id} {
    set myparams [dict create id $id]

    tdbc::postgres::connection create db -user danilo -password danilo -port 5432
    set stmt [db prepare {select * from Notes where id = :id}]
    $stmt execute $myparams
    set rows [$stmt allrows -as lists]

    $stmt close
    db close

    return $rows	
}

proc addNote {title body} {
    set myparams [dict create title $title body $body]
    tdbc::postgres::connection create db -user danilo -password danilo -port 5432
    set stmt [db prepare {INSERT INTO Notes (Title, Body, Created) values (:title, :body, now())}]
    set resultset [$stmt execute $myparams]
    set rowcount [$resultset rowcount]

    $resultset close
    $stmt close
    db close

    return $rowcount
}

proc updateNote {id title body} {
    set myparams [dict create id $id title $title body $body]
    tdbc::postgres::connection create db -user danilo -password danilo -port 5432
    set stmt [db prepare {UPDATE Notes SET Title = :title, Body = :body where Id = :id}]
    set resultset [$stmt execute $myparams]
    set rowcount [$resultset rowcount]

    $resultset close
    $stmt close
    db close

    return $rowcount
}

proc deleteNote {id} {
    set myparams [dict create id $id]
    tdbc::postgres::connection create db -user danilo -password danilo -port 5432
    set stmt [db prepare {DELETE FROM Notes where Id = :id}]
    set resultset [$stmt execute $myparams]
    set rowcount [$resultset rowcount]

    $resultset close
    $stmt close
    db close

    return $rowcount
}

