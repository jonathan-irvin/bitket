class Type_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addType($name)
	{
		$this->db->set('name', $name); 
		$this->db->insert('bk_types'); 
	}
    
    function getTypes()
    {
		$query = $this->db->get('bk_types');		
		
		foreach ($query->result() as $row)
		{			
			echo $row->name;			
		}
	}
	
	function updateType($id,$newname)
	{
		$data = array(
		   'type_id' => $id,
		   'name' => $newname
        );

		$this->db->update('bk_types', $data)->where('type_id', $id); 
	}
	
	function deleteType($id)
	{
		$this->db->delete('bk_types', array('id' => $id))
	}
}
