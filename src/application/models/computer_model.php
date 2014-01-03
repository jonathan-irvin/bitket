class Computer_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addComputer($ticket_id,$customer_id)
	{
		$this->db->set('ticket_id', $ticket_id); 
		$this->db->set('customer_id', $customer_id); 
		$this->db->insert('bk_computers'); 
	}
    
    function getComputers()
    {
		$query = $this->db->get('bk_computers');		
		
		foreach ($query->result() as $row)
		{			
			echo $row->ticket_id;
			echo $row->customer_id;
		}
	}
	
	function updateComputers($data)
	{
		$this->db->update('bk_types', $data, array('computer_id' => $id)); 
	}
	
	function deleteComputer($id)
	{
		$this->db->delete('bk_types', array('computer_id' => $id))
	}
}
