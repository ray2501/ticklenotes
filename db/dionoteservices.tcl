package require DIO

proc getAllNotes {} {
    set rows {}
    set db [::DIO::handle Postgresql -host localhost -port 5432 -user danilo -pass danilo -db danilo]

    set rows [list]
    $db forall {select id, title, body, created from Notes order by created} row {
        set myrow [list $row(id) $row(title) $row(body) $row(created)]
        lappend rows $myrow
    }

    $db destroy
    return $rows
}

proc getNote {id} {
    set rows {}
    set db [::DIO::handle Postgresql -host localhost -port 5432 -user danilo -pass danilo -db danilo]

    set query "select id, title, body, created from Notes where id = '$id'"
    set rows [list]
    $db forall $query row {
        set myrow [list $row(id) $row(title) $row(body) $row(created)]
        lappend rows $myrow
    }

    $db destroy
    return $rows	
}

proc addNote {title body} {
    set db [::DIO::handle Postgresql -host localhost -port 5432 -user danilo -pass danilo -db danilo]

    set arrayVar(Title) $title
    set arrayVar(Body) $body
    set arrayVar(Created) "now()"
    set rowcount [$db insert Notes arrayVar]

    $db destroy
    return $rowcount
}

proc updateNote {id title body} {
    set db [::DIO::handle Postgresql -host localhost -port 5432 -user danilo -pass danilo -db danilo]

    set arrayVar(Id) $id
    set arrayVar(Title) $title
    set arrayVar(Body) $body
    set rowcount [$db update arrayVar -table Notes -keyfield Id]

    $db destroy
    return $rowcount
}

proc deleteNote {id} {
    set db [::DIO::handle Postgresql -host localhost -port 5432 -user danilo -pass danilo -db danilo]

    set rowcount [$db delete $id -table Notes -keyfield Id]

    $db destroy	
    return $rowcount
}

