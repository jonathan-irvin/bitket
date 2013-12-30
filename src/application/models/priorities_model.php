class Priorities_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addPriority($name,$description)
	{
		$this->db->set('name', $name); 
		$this->db->set('description', $description);
		$this->db->insert('bk_priorities'); 
	}
    
    function getpriorities()
    {
		$query = $this->db->get('bk_priorities');		
		
		foreach ($query->result() as $row)
		{			
			echo $row->name;			
		}
	}
	
	function updatePriorityName($id,$newname)
	{
		$data = array(
		   'priority_id' => $id,
		   'name' => $newname
        );

		$this->db->update('bk_priorities', $data)->where('priority_id', $id); 
	}
	
	function updatePrioritySLA($id,$newSLA)
	{
		$data = array(
		   'priority_id' => $id,
		   'sla' => $sla
        );

		$this->db->update('bk_priorities', $data)->where('priority_id', $id); 
	}
	function updatePriorityDescription($id,$newdescription)
	{
		$data = array(
		   'priority_id' => $id,
		   'description' => $newdescription
        );

		$this->db->update('bk_priorities', $data)->where('priority_id', $id); 
	}
	
	function deletePriority($id)
	{
		$this->db->delete('bk_priorities', array('priority_id' => $id))
	}
}
