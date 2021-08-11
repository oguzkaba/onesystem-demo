class MysqlQuery {
  Map queryList = {
    'login': 'SELECT * FROM *.user where user_Name=? and user_Password=?',
    'getSpool': 'SELECT * FROM spool_list where fileNo_id=?',
    'getWeld': 'SELECT * FROM *.weld_list where fileNo_id=? and spoolNo_id=?',
    'getFileNO': 'SELECT * FROM file_no',
    'getFileNoSpool':
        'SELECT fileNo_id,spool,userNote_id FROM *.spool_list where fabrication=?',
    'getUserNote': 'SELECT * FROM *.user_note  where file_spool=?',
    'getNoteByUser': 'SELECT * FROM *.user where id=?',
    'addNoteUser':
        'INSERT INTO *.user_note(note, visibility, activate, user_Id, file_spool) VALUES (?,?,?,?,?)'
  };
}
