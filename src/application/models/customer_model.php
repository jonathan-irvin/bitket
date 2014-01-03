class Customer_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addCustomer($name)
	{
		$this->db->set('name', $name); 
		$this->db->insert('bk_customers'); 
	}
    
    function getCustomers()
    {
		$query = $this->db->get('bk_customers');		
		
		foreach ($query->result() as $row)
		{			
			echo $row->name;			
		}
	}
	
	function updateCustomer($id,$newname)
	{
		$data = array(
		   'type_id' => $id,
		   'name' => $newname
        );

		$this->db->update('bk_customers', $data, array('type_id' => $id)); 
	}
	
	function deleteCustomer($id)
	{
		$this->db->delete('bk_customers', array('type_id' => $id))
	}
}
