class Options_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addOption($name,$value)
	{
		$this->db->set('options_name', $name); 
		$this->db->set('options_value', $value); 
		$this->db->insert('bk_options'); 
	}    
	
	function getOption($name)
    {
		$query = $this->db->get_where('bk_options',array('options_name'=>$name));		
		
		if ($query->num_rows() > 0)
		{
		   foreach ($query->result() as $row)
		   {
			  echo $row->option_value;
		   }
		}
	}
	
	function updateOption($id,$name,$value)
	{
		$data = array(
		   'option_value' => $value
        );

		$this->db->update('bk_options', $data, array('option_name' => $name)); 
	}
	
	function deleteOption($name)
	{
		$this->db->delete('bk_options', array('type_id' => $id))
	}
}
