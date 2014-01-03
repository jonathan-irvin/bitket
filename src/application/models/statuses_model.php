class Statuses_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addStatus($name, $description)
	{
		$this->db->set('name', $name); 
		$this->db->set('description', $description); 
		$this->db->insert('bk_status'); 
	}
    
    function getStatusName()
    {
		$query = $this->db->get('bk_status');		
		
		foreach ($query->result() as $row)
		{			
			echo $row->name;						
		}
	}
	
	function updateStatus($id,$newname,$newdescription)
	{
		$data = array(
		   'status_id' => $id,
		   'name' => $newname,
		   'description' => $newdescription,
        );

		$this->db->update('bk_status', $data, array('status_id' => $id)); 
	}
	
	function deleteStatus($id)
	{
		$this->db->delete('bk_status', array('status_id' => $id))
	}
}
